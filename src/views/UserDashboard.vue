<template>
  <aside
    class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0"
  >
    <div class="h-full px-3 py-4 overflow-y-auto bg-gray-800">
      <ul class="space-y-2 font-medium">
        <li v-for="form in formRoutes" :key="form.path">
          <router-link
            :to="form.path"
            class="flex p-2 rounded-lg hover:bg-gray-700 hover:text-blue-400 group"
            :class="{ 'text-blue-400 bg-gray-700': $route.path === form.path }"
          >
            <span>{{ form.label }}</span>
          </router-link>
        </li>
      </ul>
    </div>
  </aside>

  <div
    class="p-4 ml-32 px-32 bg-gray-700 h-[100vh] text-slate-100 overflow-x-hidden overflow-y-auto"
  >
    <router-view />
  </div>
</template>

<script lang="ts">
export interface FormRoute {
  label: string
  path: string
}

const formRoutes: FormRoute[] = [
  { label: 'Contact', path: '/dashboard/forms/contact' },
  { label: 'Investment', path: '/dashboard/forms/investment' },
  { label: 'Pre-Sale', path: '/dashboard/forms/pre-sale' }
]

export default {
  name: 'UserDashboard',
  setup() {
    return { formRoutes }
  }
}
</script>
