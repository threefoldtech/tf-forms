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
            Login as admin!
          </h2>
        </div>

        <div class="mt-10">
          <div>
            <FormManager
              :data="{
                email,
                code
              }"
              :hx="{
                post: $api + '/admin/login',
                ext: 'json-enc'
              }"
              @before:submit="loading = true"
              @after:submit="afterRequest"
            >
              <t-input
                label="Email"
                placeholder="Your admin email"
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

              <t-input
                label="Password"
                placeholder="Your admin Password"
                name="password"
                required
                v-model="code"
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
    <div class="relative hidden w-0 flex-1 lg:block bg-clip-border">
      <img
        class="absolute inset-0 h-full w-full object-cover"
        src="@/assets/login-parallax.jpg"
        alt="login"
      />
    </div>
  </div>
</template>

<script lang="ts">
import { ref } from 'vue'
import FormManager from '@/components/FormManager.vue'
import { TBtn, TInput, TAlert } from '@/components/tailwind'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

export default {
  name: 'LoginAdmin',
  components: { TInput, FormManager, TBtn, TAlert },
  setup() {
    const email = ref('')
    const code = ref('')
    const loading = ref(false)
    const error = ref('')
    const router = useRouter()
    const authStore = useAuthStore()

    function afterRequest(response: { message?: string }) {
      loading.value = false
      if (response.message) {
        error.value = response.message
      } else {
        authStore.addUser({ email: email.value, code: code.value, isAdmin: true })
        router.push('/dashboard/admin/contacts')
      }
    }

    return { email, code, loading, error, afterRequest }
  }
}
</script>
