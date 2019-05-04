import * as React from "react";
import IGlobalNavItem from "./model/IGlobalNavItem";
import GlobalNavNode from "./GlobalNavNode";
import GlobalNavProvider from "./provider/GlobalNavProvider";

require("./globalNavStyles.scss"); 

export interface IGlobalNavProps {
  webUrl?: string;
}

export interface IGlobalNavState {
  globalNavItems: IGlobalNavItem[];
}

export default class Header extends React.Component<
  IGlobalNavProps,
  IGlobalNavState
> {
  private globalNavProvider: GlobalNavProvider;

  constructor(props: IGlobalNavProps) {
    super(props);

    this.state = {
      globalNavItems: []
    };
  }

  public componentWillMount(): void {
    this.globalNavProvider = new GlobalNavProvider();
  }

  public componentDidMount(): void {
    this.globalNavProvider
      .getGlobalNavigation()
      .then(
        (result: IGlobalNavItem[]): void => {
          this.setState({
            globalNavItems: result
          });
        }
      )
      .catch(error => {
        console.log(error);
      });
  }

  public render(): JSX.Element {
    return (
      <div className="global-nav">
        <ul className="root">
          {this.state.globalNavItems.map(
            (globalNavItem: IGlobalNavItem, index: number) => (
              <GlobalNavNode key={index} globalNavItem={globalNavItem} />
            )
            )}
        </ul>
      </div>
    );
  }
}
