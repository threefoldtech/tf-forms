import { defineStore } from 'pinia'

export interface UserModel {
  email: string
  code: string
}

export interface AuthState {
  user: UserModel | null
}

const USER_KEY = 'USER'

function getLocalStorageUser() {
  let user: UserModel | null = null
  const maybeUser = localStorage.getItem(USER_KEY)
  if (maybeUser) {
    try {
      user = JSON.parse(maybeUser)
    } catch {
      /* pass */
    }
  }
  return user
}

function setLocalStorageUser(user: UserModel | null) {
  if (user === null) {
    localStorage.removeItem(USER_KEY)
  } else {
    localStorage.setItem(USER_KEY, JSON.stringify(user))
  }
}

export const useAuthStore = defineStore('auth', {
  state(): AuthState {
    return { user: getLocalStorageUser() }
  },

  actions: {
    login(user: UserModel) {
      setLocalStorageUser(user)
      this.$state.user = user
    },
    logout() {
      setLocalStorageUser(null)
      this.$state.user = null
    }
  },
  getters: {
    isLogin(): boolean {
      return this.user !== null
    }
  }
})
