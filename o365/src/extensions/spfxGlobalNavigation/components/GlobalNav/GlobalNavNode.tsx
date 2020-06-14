import * as React from "react";
import IGlobalNavNode from "./model/IGlobalNavNode";
import IGlobalNavItem from "./model/IGlobalNavItem";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCaretRight, faCaretDown } from "@fortawesome/free-solid-svg-icons";
import slugify from "slugify";

export interface IGlobalNavNodeProps extends IGlobalNavNode {}

export default class GlobalNavNode extends React.Component<
  IGlobalNavNodeProps,
  {}
> {
  public render(): JSX.Element {
    const titleClassName = slugify(this.props.globalNavItem.title, {
      lower: true,
    });
    return (
      <li
        key={this.props.globalNavItem.id}
        className={
          this.props.globalNavItem.subNavItems
            ? `td-dropdown ${titleClassName}`
            : `${titleClassName}`
        }
        data-level={this.props.globalNavItem.level}
      >
        <a
          href={this.props.globalNavItem.url || "#"}
          target={this.props.globalNavItem.openInNewWindow ? "_blank" : "_self"}
        >
          {this.props.globalNavItem.title}
          {console.log(this.props.globalNavItem)}
          {this.props.globalNavItem.subNavItems &&
            this.props.globalNavItem.level > 0 && (
              <FontAwesomeIcon icon={faCaretRight} className="gn-icon"></FontAwesomeIcon>
            )}
          {this.props.globalNavItem.subNavItems &&
            this.props.globalNavItem.level <= 0 && (
              <FontAwesomeIcon icon={faCaretDown} className="gn-icon"></FontAwesomeIcon>
            )}
        </a>
        {this.props.globalNavItem.subNavItems && (
          <ul
            className="td-dropdown-menu"
            data-level={this.props.globalNavItem.level + 1}
          >
            {this.props.globalNavItem.subNavItems.map(
              (globalNavItem: IGlobalNavItem) => (
                <GlobalNavNode
                  key={parseInt(globalNavItem.id)}
                  globalNavItem={globalNavItem}
                />
              )
            )}
          </ul>
        )}
      </li>
    );
  }
}
