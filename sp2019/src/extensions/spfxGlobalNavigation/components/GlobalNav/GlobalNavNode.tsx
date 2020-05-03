import * as React from "react";
import IGlobalNavNode from "./model/IGlobalNavNode";
import IGlobalNavItem from "./model/IGlobalNavItem";
import slugify from "slugify";

export interface IGlobalNavNodeProps extends IGlobalNavNode { }

export default class GlobalNavNode extends React.Component<IGlobalNavNodeProps, {}> {
  public render(): JSX.Element {
    const titleClassName: string = slugify(this.props.globalNavItem.title, { lower: true });
    const caretClassName: string = this.props.globalNavItem.level > 0 ? "ms-Icon--CaretSolidRight" : "ms-Icon--CaretSolidDown";
    return (
      <li
        key={this.props.globalNavItem.id}
        className={this.props.globalNavItem.subNavItems ? `td-dropdown ${titleClassName}` : `${titleClassName}`}
        data-level={this.props.globalNavItem.level}
      >
        <a
          href={this.props.globalNavItem.url || "#"}
          target={this.props.globalNavItem.openInNewWindow ? "_blank" : "_self"}
        >
          {this.props.globalNavItem.title}
          {console.log(this.props.globalNavItem)}
          {this.props.globalNavItem.subNavItems && <i className={`ms-Icon ${caretClassName}`} />}
        </a>
        {this.props.globalNavItem.subNavItems && (
          <ul className="td-dropdown-menu" data-level={this.props.globalNavItem.level + 1}>
            {this.props.globalNavItem.subNavItems.map((globalNavItem: IGlobalNavItem) => (
              <GlobalNavNode key={globalNavItem.id} globalNavItem={globalNavItem} />
            ))}
          </ul>
        )}
      </li>
    );
  }
}
