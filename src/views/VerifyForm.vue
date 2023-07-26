<template>
  <div class="flex min-h-[100vh] flex-1">
    <div
      class="flex flex-1 flex-col justify-center px-4 py-12 sm:px-6 lg:flex-none lg:px-20 xl:px-24"
    >
      <div class="mx-auto w-full max-w-sm lg:w-96">
        <div>
          <img
            class="h-10 w-auto"
            src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
            alt="Your Company"
          />
          <h2 class="mt-8 text-2xl font-bold leading-9 tracking-tight text-gray-900">
            Verify your account
          </h2>
        </div>

        <div class="mt-10">
          <div>
            <FormManager
              :hx="{ post: 'https://4bd3-156-203-129-143.ngrok-free.app/verify', ext: 'json-enc' }"
              :data="{ email, code }"
              @before:submit="loading = true"
              @after:submit="loading = false"
            >
              <t-input
                label="Email"
                placeholder="Your email address"
                name="email"
                required
                v-model="email"
              />
              <t-input
                label="Code"
                type="password"
                placeholder="Your code"
                name="code"
                required
                v-model="code"
              />

              <div>
                <button
                  type="submit"
                  class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                  :disabled="loading"
                >
                  {{ loading ? 'Loading...' : 'Register' }}
                </button>
              </div>
            </FormManager>
          </div>
        </div>
      </div>
    </div>
    <div class="relative hidden w-0 flex-1 lg:block">
      <img
        class="absolute inset-0 h-full w-full object-cover"
        src="https://images.unsplash.com/photo-1496917756835-20cb06e75b4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1908&q=80"
        alt=""
      />
    </div>
  </div>
</template>

<script lang="ts">
import { ref } from 'vue'
import { TInput } from '../components/tailwind'
import FormManager from '@/components/FormManager.vue'

export default {
  name: 'VerifyForm',
  components: { TInput, FormManager },
  setup() {
    const email = ref('')
    const code = ref('')
    const loading = ref(false)

    /* store el code */

    return { email, code, loading }
  }
}
</script>
