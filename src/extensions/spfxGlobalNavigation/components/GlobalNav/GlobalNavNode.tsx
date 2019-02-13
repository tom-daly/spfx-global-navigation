import * as React from "react";
import IGlobalNavNode from "./model/IGlobalNavNode";
import IGlobalNavItem from "./model/IGlobalNavItem";

export interface IGlobalNavNodeProps extends IGlobalNavNode {}

export default class GlobalNavNode extends React.Component<
  IGlobalNavNodeProps,
  {}
> {

  public render(): JSX.Element {
    return (
      <li key={this.props.key} className={this.props.globalNavItem.subNavItems ? "td-dropdown" : ""}>
        <a href={this.props.globalNavItem.url || "#"} target={this.props.globalNavItem.openInNewWindow ? "_blank" : "_self"}>
          {this.props.globalNavItem.title}
          {
            this.props.globalNavItem.subNavItems && (
              <i className="ms-Icon ms-Icon--CaretSolidDown"></i>
            )
          }
        </a>
        {this.props.globalNavItem.subNavItems && (
          <ul className="td-dropdown-menu">
            {this.props.globalNavItem.subNavItems.map(
              (globalNavItem: IGlobalNavItem, index: number) => (
                <GlobalNavNode key={index} globalNavItem={globalNavItem} />
              )
            )}
          </ul>
        )}
      </li>
    );
  }
}
