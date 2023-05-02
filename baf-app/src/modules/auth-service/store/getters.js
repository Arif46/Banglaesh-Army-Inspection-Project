export default {
    isLoggedIn: state => state.isLoggedIn,
    userTypeList: state => state.userTypeList,
    authUser: state => state.authUser,
    getAuthorizedComponents: (state) => state.authorizedComponents,
    getActiveRole: state => state.activeRoleId,
    getAuthorizedUris: state => state.authorizedURIs,
    getActiveMenus: state => state.activeMenus,
    getAuthUserRoles: state => state.authUserRoles,
    commonProfile: state => state.commonProfile
}
