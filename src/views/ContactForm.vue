<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Contact Form</h1>

    <FormManager
      :hx="{
        post: $api + '/contacts',
        ext: 'json-enc'
      }"
      :data="{
        email: authStore.user?.email,
        code: authStore.user?.code,
        phone,
        about,
        interests: {
          tf_cloud: cloud,
          venture_creator: venture,
          licenses,
          dk
        }
      }"
      @before:submit="
        () => {
          loading = true
          error = ''
          success = false
        }
      "
      @after:submit="afterRequest"
      v-if="init"
    >
      <FormPages v-model="contactForm" />

      <div class="mt-7">
        <div class="mb-3" v-if="success || error">
          <t-alert :type="success ? 'success' : 'error'">
            {{ error || 'Successfully saved your form.' }}
          </t-alert>
        </div>
        <FormPagination :length="contactForm.length" :loading="loading" />
      </div>
    </FormManager>
    <p v-else class="font-bold animate-pulse text-center mt-32">Loading...</p>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, contactFormData, hasFormData, setData } from '@/data'
import { computed, onMounted, ref, inject } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { TAlert } from '@/components/tailwind'

const KEY = 'CONTACT_FORM'

export default {
  name: 'ContactForm',
  components: { FormManager, FormPages, FormPagination, TAlert },
  setup() {
    const loading = ref(false)
    const authStore = useAuthStore()
    const error = ref('')
    const success = ref(false)
    const init = ref(false)

    const $globals = inject('$globals')! as { $api: string }
    const contactForm = useFormData(KEY, contactFormData)

    onMounted(async () => {
      if (!hasFormData(KEY)) {
        const res = await fetch(
          $globals.$api +
            '/contacts?email=' +
            authStore.user!.email +
            '&code=' +
            authStore.user!.code
        )
        const data = await res.json()

        if (!data.message) {
          contactForm.value = setData(contactFormData, {
            0: {
              1: data.phone,
              2: data.about,
              4: data.interests['tf_cloud'],
              5: data.interests['venture_creator'],
              6: data.interests['licenses'],
              7: data.interests['dk']
            }
          })
        }
      }
      init.value = true
    })

    function afterRequest(res: { message?: string }) {
      loading.value = false
      if (res.message) {
        error.value = res.message
      } else {
        success.value = true
      }
    }

    return {
      contactForm,
      phone: computed(() => contactForm.value[0][1].value),
      about: computed(() => contactForm.value[0][2].value),
      cloud: computed(() => String(contactForm.value[0][4].value)),
      venture: computed(() => String(contactForm.value[0][5].value)),
      licenses: computed(() => String(contactForm.value[0][6].value)),
      dk: computed(() => String(contactForm.value[0][7].value)),
      loading,
      authStore,
      error,
      success,
      afterRequest,
      init
    }
  }
}
</script>
