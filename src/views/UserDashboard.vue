<template>
  <div>
    <div class="hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-72 lg:flex-col">
      <div class="flex grow flex-col gap-y-5 overflow-y-auto bg-indigo-600 px-6 pb-4">
        <div class="flex h-16 shrink-0 items-center">
          <img
            class="h-8 w-auto"
            src="https://tailwindui.com/img/logos/mark.svg?color=white"
            alt="Your Company"
          />
        </div>
        <nav class="flex flex-1 flex-col">
          <ul role="list" class="flex flex-1 flex-col gap-y-7">
            <li v-for="route in dashboardRoutes" :key="route.label">
              <div class="text-xs font-semibold leading-6 text-indigo-200">{{ route.label }}</div>
              <ul role="list" class="-mx-2 mt-2 space-y-1">
                <li v-for="r in route.routes" :key="r.name">
                  <router-link
                    :to="r.path"
                    :class="[
                      $route.path === r.path
                        ? 'bg-indigo-700 text-white'
                        : 'text-indigo-200 hover:text-white hover:bg-indigo-700',
                      'group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold'
                    ]"
                  >
                    <span
                      class="flex h-6 w-6 shrink-0 items-center justify-center rounded-lg border border-indigo-400 bg-indigo-500 text-[0.625rem] font-medium text-white"
                    >
                      {{ r.initial }}
                    </span>
                    <span class="truncate">{{ r.name }}</span>
                  </router-link>
                </li>
              </ul>
            </li>
          </ul>
        </nav>
      </div>
    </div>

    <div class="lg:pl-72">
      <div
        class="sticky top-0 z-40 flex h-16 shrink-0 items-center gap-x-4 border-b border-gray-200 bg-white px-4 shadow-sm sm:gap-x-6 sm:px-6 lg:px-8"
      >
        <div class="flex flex-1 gap-x-4 self-stretch lg:gap-x-6 justify-end">
          <div class="flex items-center gap-x-4 lg:gap-x-6">
            <t-menu as="div" class="relative">
              <t-menu-button class="-m-1.5 flex items-center p-1.5">
                <span class="sr-only">Open user menu</span>
                <span class="hidden lg:flex lg:items-center">
                  <span
                    class="ml-4 text-sm font-semibold leading-6 text-gray-900"
                    aria-hidden="true"
                  >
                    {{ authStore.$state.user?.email }}
                  </span>
                  <ChevronDownIcon class="ml-2 h-5 w-5 text-gray-400" aria-hidden="true" />
                </span>
              </t-menu-button>
              <transition
                enter-active-class="transition ease-out duration-100"
                enter-from-class="transform opacity-0 scale-95"
                enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75"
                leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95"
              >
                <t-menu-items
                  class="absolute right-0 z-10 mt-2.5 w-32 origin-top-right rounded-md bg-white py-2 shadow-lg ring-1 ring-gray-900/5 focus:outline-none"
                >
                  <t-menu-item v-slot="{ active }">
                    <a
                      href="#"
                      @click.prevent="logout"
                      :class="[
                        active ? 'bg-gray-50' : '',
                        'block px-3 py-1 text-sm leading-6 text-gray-900'
                      ]"
                    >
                      Logout
                    </a>
                  </t-menu-item>
                </t-menu-items>
              </transition>
            </t-menu>
          </div>
        </div>
      </div>

      <main class="py-10">
        <div class="px-4 sm:px-6 lg:px-8">
          <router-view />
        </div>
      </main>
    </div>
  </div>
</template>

<script lang="ts">
import { ref } from 'vue'
import { Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/vue'
import { useAuthStore } from '@/stores/auth'
import { useRouter } from 'vue-router'

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
  components: {
    TMenu: Menu,
    TMenuItem: MenuItem,
    TMenuButton: MenuButton,
    TMenuItems: MenuItems
  },
  setup() {
    const sidebarOpen = ref(false)
    const authStore = useAuthStore()
    const router = useRouter()

    function logout() {
      authStore.logout()
      router.push('/login')
    }

    return {
      authStore,
      formRoutes,
      sidebarOpen,
      userNavigation: [
        { name: 'Your profile', href: '#' },
        { name: 'Sign out', href: '#' }
      ],
      dashboardRoutes: [
        {
          label: 'Your Forms',
          routes: [
            { name: 'Contact Form', path: '/dashboard/forms/contact', initial: 'C' },
            { name: 'Investment Form', path: '/dashboard/forms/investment', initial: 'T' },
            { name: 'Pre-Sale Form', path: '/dashboard/forms/pre-sale', initial: 'W' }
          ]
        }
      ],
      logout
    }
  }
}
</script>
