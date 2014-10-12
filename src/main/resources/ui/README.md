OpenIDM UI Customizations
=========================

Within this folder, you can define your custom OpenIDM UI. You have two choices for customizations:

1. Adding in new versions of files that exist in the default OpenIDM UI
2. Providing a whole new UI context
 
If you want to make simple changes to the default enduser UI found under https://localhost:8443/openidmui, your easiest option would be to add files under the "ui/extenstion/*" subfolders. Files added here will be used in place of the files of the same name found under "ui/default/enduser/public". These will be tracked completely apart from the code for OpenIDM UI, which could be beneficial for tracking changes.

If you need to make more extensive changes to the default OpenIDM UI, you can place your version of the UI code under the "ui/default/enduser/public" folder. When this project is built, the files you place in here will be put alongside (or on top of) the existing OpenIDM UI.