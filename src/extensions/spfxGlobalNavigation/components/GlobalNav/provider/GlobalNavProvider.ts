import IGlobalNavItem from "../model/IGlobalNavItem";
import ISPGlobalNavItem from "../model/ISPGlobalNavItem";
import { sp } from "@pnp/sp";

export default class GlobalNavProvider {
  constructor() {
    sp.setup({
      sp: {
        //baseUrl: `${window.location.protocol}//${window.location.hostname}`
        baseUrl: `https://bandrdev.sharepoint.com/sites/globalnav`
      }
    });
  }

  public getGlobalNavigation(): Promise<IGlobalNavItem[]> {
    return (
      sp.web.lists
        .getByTitle("Global Nav List")
        .items.select(
          "Title",
          "GlobalNavUrl",
          "GlobalNavOpenInNewWindow",
          "GlobalNavParent/Title"
        )
        .expand("GlobalNavParent")
        .orderBy("GlobalNavOrder")
        .get()
        .then(
          (items: ISPGlobalNavItem[]): IGlobalNavItem[] => {
            let globalNavItems: IGlobalNavItem[] = [];
            items.forEach(
              (item: ISPGlobalNavItem): void => {
                if (!item.GlobalNavParent) {
                  globalNavItems.push({
                    title: item.Title,
                    url: item.GlobalNavUrl,
                    openInNewWindow: item.GlobalNavOpenInNewWindow,
                    subNavItems: this._getSubNavItems(items, item.Title)
                  });
                }
              }
            );
            return globalNavItems;
          }
        )
    );
  }

  private _getSubNavItems(
    spNavItems: ISPGlobalNavItem[],
    filter: string
  ): IGlobalNavItem[] {
    let subNavItems: IGlobalNavItem[] = [];
    spNavItems.forEach(
      (item: ISPGlobalNavItem): void => {
        if (item.GlobalNavParent && item.GlobalNavParent.Title === filter) {
          subNavItems.push({
            title: item.Title,
            url: item.GlobalNavUrl,
            openInNewWindow: item.GlobalNavOpenInNewWindow
          });
        }
      }
    );
    return subNavItems.length > 0 ? subNavItems : null;
  }
}
