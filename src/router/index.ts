import {
  createRouter,
  createWebHistory,
  type NavigationGuardNext,
  type RouteLocationNormalized
} from 'vue-router'
import { useAuthStore } from '@/stores/auth'

function shouldBeNotLogin(
  _: RouteLocationNormalized,
  __: RouteLocationNormalized,
  next: NavigationGuardNext
) {
  const auth = useAuthStore()
  if (!auth.isLogin) return next()
  return next({ path: '/dashboard/forms/contact' })
}

function shouldBeLogin(
  _: RouteLocationNormalized,
  __: RouteLocationNormalized,
  next: NavigationGuardNext
) {
  const auth = useAuthStore()
  if (auth.isLogin) return next()
  return next({ path: '/login' })
}

function shouldBeAdmin(
  _: RouteLocationNormalized,
  __: RouteLocationNormalized,
  next: NavigationGuardNext
) {
  const auth = useAuthStore()
  if (auth.isLogin && auth.isAdmin) return next()
  return next({ path: '/login' })
}

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      component: () => import('../views/LoginForm.vue')
      // beforeEnter: [shouldBeNotLogin]
    },
    {
      path: '/verify',
      component: () => import('../views/VerifyForm.vue')
      // beforeEnter: [shouldBeNotLogin]
    },
    {
      path: '/admin',
      component: () => import('../views/LoginAdmin.vue')
      // beforeEnter: [shouldBeNotLogin]
    },
    {
      path: '/dashboard',
      component: () => import('../views/UserDashboard.vue'),
      beforeEnter: [shouldBeLogin],
      children: [
        {
          path: '/dashboard/admin/:form',
          component: () => import('../views/AdminView.vue'),
          beforeEnter: [shouldBeAdmin]
        },
        {
          path: '/dashboard/forms/contact',
          component: () => import('../views/ContactForm.vue'),
          beforeEnter: [shouldBeLogin]
        },
        {
          path: '/dashboard/forms/investment',
          component: () => import('../views/InvestmentForm.vue'),
          beforeEnter: [shouldBeLogin]
        },
        {
          path: '/dashboard/forms/pre-sale',
          component: () => import('../views/PresaleForm.vue'),
          beforeEnter: [shouldBeLogin]
        }
      ]
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/login'
    }
  ]
})

export default router
