export default interface ISPGlobalNavItem {
  Title: string;
  GlobalNavUrl?: string;
  GlobalNavOpenInNewWindow?: boolean;
  GlobalNavParent?: {
    Title: string;
  };
}
