export default interface IGlobalNavItem {
  title: string;
  url?: string;
  openInNewWindow?: boolean;
  subNavItems?: IGlobalNavItem[];
}
