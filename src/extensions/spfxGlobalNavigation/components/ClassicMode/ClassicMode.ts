import "@babel/polyfill";
import * as React from "react";
import * as ReactDOM from "react-dom";
import GlobalNav from "../GlobalNav/GlobalNav";

require("./classicModeStyles.scss");

window.addEventListener('load', () => {
    let topNavNode = document.getElementById("DeltaTopNavigation");
    ReactDOM.render(
        React.createElement(GlobalNav, {}),
        topNavNode
    );
});
