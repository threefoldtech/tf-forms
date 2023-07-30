<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Contact Form</h1>

    <FormManager
      :hx="{
        post: $api + '/contacts',
        ext: 'json-enc'
      }"
      :data="{
        email: 'elmdarym@incubaid.com',
        code: 'mohamed',
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
import { computed, ref } from 'vue'

const KEY = 'CONTACT_FORM'

export default {
  name: 'ContactForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const contactForm = useFormData(KEY, contactFormData)
    const loading = ref(false)

    return {
      contactForm,
      phone: computed(() => contactForm.value[0][1].value),
      about: computed(() => contactForm.value[0][2].value),
      cloud: computed(() => String(contactForm.value[0][4].value)),
      venture: computed(() => String(contactForm.value[0][5].value)),
      licenses: computed(() => String(contactForm.value[0][6].value)),
      dk: computed(() => String(contactForm.value[0][7].value)),
      loading
    }
  }
}
</script>
