import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      component: () => import('../views/LoginForm.vue')
    },
    {
      path: '/verify',
      component: () => import('../views/VerifyForm.vue')
    },
    {
      path: '/dashboard',
      component: () => import('../views/UserDashboard.vue'),
      children: [
        {
          path: '/dashboard/forms/contact',
          component: () => import('../views/ContactForm.vue')
        },
        {
          path: '/dashboard/forms/investment',
          component: () => import('../views/InvestmentForm.vue')
        },
        {
          path: '/dashboard/forms/pre-sale',
          component: () => import('../views/PresaleForm.vue')
        }
      ]
    }
  ]
})

export default router
