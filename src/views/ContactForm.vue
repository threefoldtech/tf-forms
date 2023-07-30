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
          'tf-cloud': cloud,
          'venture-creator': venture,
          licenses,
          dk
        }
      }"
      @before:submit="loading = true"
      @after:submit="loading = false"
    >
      <FormPages v-model="contactForm" />

      <div class="mt-7">
        <FormPagination :length="contactForm.length" :loading="loading" />
      </div>
    </FormManager>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, contactFormData } from '@/data'
import { computed, onMounted, ref } from 'vue'
import { useAuthStore } from '@/stores/auth'

const KEY = 'CONTACT_FORM'

export default {
  name: 'ContactForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const contactForm = useFormData(KEY, contactFormData)
    const loading = ref(false)
    const authStore = useAuthStore()

    onMounted(() => {
      fetch(
        `https://e68f-156-203-159-109.ngrok-free.app/contacts?email=${authStore.user!.email}&code=${
          authStore.user!.code
        }`
      )
        .then((res) => res.text())
        .then(console.log)
    })

    return {
      contactForm,
      phone: computed(() => contactForm.value[0][1].value),
      about: computed(() => contactForm.value[0][2].value),
      cloud: computed(() => String(contactForm.value[0][4].value)),
      venture: computed(() => String(contactForm.value[0][5].value)),
      licenses: computed(() => String(contactForm.value[0][6].value)),
      dk: computed(() => String(contactForm.value[0][7].value)),
      loading,
      authStore
    }
  }
}
</script>
