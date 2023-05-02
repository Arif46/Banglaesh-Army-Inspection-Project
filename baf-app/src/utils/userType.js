import Store from '@/store'

const userType = (typeName) => {
  const auth = Store.state.Auth
  let tempType = {
    is_admin: 0,
    is_office_user: 0,
    is_org_admin: 0
  }

  if (parseInt(auth.authUser.user_id) === 1) {
    tempType = Object.assign(tempType, { is_admin: 1 })
  } else if (parseInt(auth.authUser.org_admin) === 2) {
    tempType = Object.assign(tempType, { is_org_admin: 2 })
  } else {
    tempType = Object.assign(tempType, { is_office_user: 1 })
  }
  return tempType[typeName]
}

export default {
  userType
}
