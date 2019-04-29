import * as React from "react";
import * as ReactDOM from "react-dom";
import GlobalNav from "../GlobalNav/GlobalNav";

require("./classic.scss");

window.addEventListener('load', function() {
    let topNavNode = document.getElementById("DeltaTopNavigation");
    ReactDOM.render(
        React.createElement(GlobalNav, {}),
        topNavNode
    );
});