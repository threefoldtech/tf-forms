import { defineStore } from 'pinia'

export interface UserModel {
  email: string
  code: string
  isAdmin?: boolean
}

export interface AuthState {
  users: UserModel[]
  user: UserModel | null
}

const USER_KEY = 'USER'
const USERS_KEY = 'USERS'

function getLocalStorage<T>(key: string, fallback: T | null = null): T | null {
  let value: T | null = fallback
  const maybeValue = localStorage.getItem(key)
  if (maybeValue) {
    try {
      value = JSON.parse(maybeValue)
    } catch {
      /* Pass */
    }
  }
  return value
}

function setLocalStorage<T>(key: string, user: T) {
  if (user === null) {
    localStorage.removeItem(key)
  } else {
    localStorage.setItem(key, JSON.stringify(user))
  }
}

function clearFormLocalStorage() {
  setLocalStorage('INVESTMENT_FORM', null)
  setLocalStorage('CONTACT_FORM', null)
  setLocalStorage('PRESALE_FORM', null)
}

export const useAuthStore = defineStore('auth', {
  state(): AuthState {
    return {
      users: getLocalStorage<UserModel[]>(USERS_KEY, [])!,
      user: getLocalStorage<UserModel>(USER_KEY)
    }
  },

  actions: {
    addUser(user: UserModel) {
      this.users = [...this.users, user]
      setLocalStorage(USERS_KEY, this.users)
      this.login(user)
    },
    removeUser(email: string) {
      this.users = this.users.filter((user) => user.email !== email)
      setLocalStorage(USERS_KEY, this.users)
      const currentEmail = this.user?.email
      this.logout()
      if (currentEmail === email && this.users.length > 0) {
        this.login(this.users[0])
        return true
      }
      return false
    },
    login(user: UserModel) {
      this.user = user
      setLocalStorage(USER_KEY, user)
      clearFormLocalStorage()
      if (user.isAdmin) location.href = '/dashboard/admin/contacts'
      else location.href = '/dashboard/forms/contact'
    },
    logout() {
      this.user = null
      setLocalStorage(USER_KEY, null)
      clearFormLocalStorage()
    }
  },
  getters: {
    isLogin(): boolean {
      return this.user !== null
    },
    isAdmin(): boolean {
      return this.user?.isAdmin === true
    }
  }
})
