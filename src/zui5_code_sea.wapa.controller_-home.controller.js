sap.ui.define(["int/ui5/template/controller/BaseController","sap/m/MessageBox","sap/ui/model/Filter","sap/ui/model/FilterOperator","sap/ui/model/json/JSONModel","sap/ui/unified/CalendarLegendItem","sap/ui/unified/DateTypeRange","sap/ui/unified/library","+
sap/ui/model/Filter","sap/ui/model/FilterOperator"],function(e,t,n,r,i,a,s,o){"use strict";var u=o.CalendarDayType;return e.extend("int.ui5.template.controller.Home",{pressTile:function(e){var t=e.getSource().data().target;this.getRouter().navTo(t,{},{},+
true)},onInit:function(){},onAfterRendering:function(){},onChangeText:function(e){this.searchText(e.getSource().getValue())},searchText:function(e){var t=[new n("SearchString",r.EQ,e)];var i=new sap.m.BusyDialog({});var a={async:true,filters:t,urlParamet+
ers:{$expand:["Files","Files/Lines"]},success:function(e){var t=this.getOwnerComponent().getModel("application");t.setData(e.results);i.close()}.bind(this),error:function(e){i.close()}.bind(this)};i.open();this.getModel("mainModel").read("/OutputSet",a)}+
,formatLines:function(e){var t="";for(var n=0;n<e.results.length;n++){t=t+"\n"+e.results[n].Line}return t}})});                                                                                                                                                