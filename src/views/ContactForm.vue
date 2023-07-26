<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Contact Form</h1>

    <FormManager>
      <FormPages v-model="contactForm" />

      <div class="mt-7">
        <FormPagination :length="contactForm.length" />
      </div>
    </FormManager>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, contactFormData } from '@/data'

import { onMounted, ref } from 'vue'

const KEY = 'CONTACT_FORM'

export default {
  name: 'ContactForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const formElement = ref(null)
    onMounted(() => (window as any).htmx.process(formElement.value))

    const contactForm = useFormData(KEY, contactFormData)

    return { contactForm, formElement }
  }
}
</script>
