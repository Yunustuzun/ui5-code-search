sap.ui.define(["sap/ui/core/mvc/Controller","sap/ui/core/routing/History"],function(e,t){"use strict";return e.extend("int.ui5.template.controller.BaseController",{getRouter:function(){return this.getOwnerComponent().getRouter()},getModel:function(e){ret+
urn this.getView().getModel(e)},setModel:function(e,t){return this.getView().setModel(e,t)},getResourceBundle:function(){return this.getOwnerComponent().getModel("i18n").getResourceBundle()},onNavBack:function(){var e=t.getInstance().getPreviousHash();if+
(e!==undefined){history.go(-1)}else{this.getRouter().navTo("master",{},true)}}})});                                                                                                                                                                            