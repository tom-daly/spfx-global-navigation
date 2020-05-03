'use strict';

const build = require('@microsoft/sp-build-web');

build.addSuppression(`Warning - [sass] The local CSS class 'ms-Grid' is not camelCase and will not be type-safe.`);
build.addSuppression(/filename should end with module.scss$/);
build.addSuppression(/error quotemark: " should be '$/);

require("./spfx-versioning")(build);

build.initialize(require('gulp'));
