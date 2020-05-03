export default interface IGlobalNavItem {
  title: string;
  url?: string;
  id: string;
  openInNewWindow: boolean;
  subNavItems: IGlobalNavItem[];
  level: number;
}
