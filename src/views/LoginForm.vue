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
            Sign in to your account
          </h2>
        </div>

        <div class="mt-10">
          <div>
            <FormManager
              :data="{
                link: 'http://localhost:5173/verify',
                email
              }"
              :hx="{
                post: 'https://4bd3-156-203-129-143.ngrok-free.app/login',
                ext: 'json-enc'
              }"
              @before:submit="loading = true"
              @after:submit="afterRequest"
            >
              <t-input
                label="Email"
                placeholder="Your email address"
                name="email"
                required
                v-model="email"
                @input="
                  () => {
                    if (error) {
                      error = ''
                    }
                  }
                "
              />

              <div class="mt-2" v-if="error">
                <TAlert type="error"> {{ error }} </TAlert>
              </div>

              <div class="mt-2">
                <t-btn type="submit" :loading="loading" block>Login</t-btn>
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
import FormManager from '@/components/FormManager.vue'
import { TBtn, TInput, TAlert } from '@/components/tailwind'
import { useRouter } from 'vue-router'

export default {
  name: 'LoginForm',
  components: { TInput, FormManager, TBtn, TAlert },
  setup() {
    const email = ref('')
    const loading = ref(false)
    const error = ref('')
    const router = useRouter()

    function afterRequest(response: { message?: string }) {
      loading.value = false
      if (response.message) {
        error.value = response.message
      } else {
        router.push('/verify')
      }
    }

    return { email, loading, error, afterRequest }
  }
}
</script>
