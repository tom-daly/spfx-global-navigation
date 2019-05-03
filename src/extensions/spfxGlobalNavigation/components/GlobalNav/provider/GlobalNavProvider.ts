import IGlobalNavItem from "../model/IGlobalNavItem";
import ISPGlobalNavItem from "../model/ISPGlobalNavItem";
import "@pnp/polyfill-ie11";
import { sp } from "@pnp/sp";

export default class GlobalNavProvider {
  constructor() {
    sp.setup({
      sp: {
        headers: {
          Accept: "application/json;odata=verbose"
        },
        baseUrl: `${window.location.protocol}//${window.location.hostname}`
      }
    });
  }

  public async getGlobalNavigation(): Promise<IGlobalNavItem[]> {
    const results = await sp.web.lists
      .getByTitle("Global Nav List")
      .items.select(
        "Title",
        "GlobalNavUrl",
        "GlobalNavOpenInNewWindow",
        "GlobalNavParent/Title"
      )
      .expand("GlobalNavParent")
      .orderBy("GlobalNavOrder")
      .get();
    return this.parseGlobalNavigationNodes(results);
  }

  private parseGlobalNavigationNodes(spGlobalNavItems: ISPGlobalNavItem[]): Promise<IGlobalNavItem[]> {
    return new Promise((resolve, reject) => {
      let globalNavItems: IGlobalNavItem[] = [];
      spGlobalNavItems.forEach(
        (item: ISPGlobalNavItem): void => {
          if (!item.GlobalNavParent.Title) {
            globalNavItems.push({
              title: item.Title,
              url: item.GlobalNavUrl,
              openInNewWindow: item.GlobalNavOpenInNewWindow,
              subNavItems: this.getSubNavItems(spGlobalNavItems, item.Title)
            });
          }
        }
      );
      resolve(globalNavItems);
    });
  }

  private getSubNavItems(
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
