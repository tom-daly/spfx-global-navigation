export default interface ISPGlobalNavItem {
  Title: string;
  Id: string;
  GlobalNavUrl?: string;
  GlobalNavOpenInNewWindow?: boolean;
  GlobalNavParent?: {
    Title: string;
  };
}
