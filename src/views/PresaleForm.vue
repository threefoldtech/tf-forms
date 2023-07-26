<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Pre-Sale Form</h1>
    {{ data }}
    <FormManager
      :hx="{
        post: 'https://jsonplaceholder.typicode.com/users',
        ext: 'json-enc'
      }"
      :data="presaleForm"
    >
      <FormPages v-model="presaleForm" />

      <div class="mt-7">
        <FormPagination :length="presaleForm.length" />
      </div>
    </FormManager>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, presaleFormData, getFormData } from '@/data'
import { computed } from 'vue'

const KEY = 'PRESALE_FORM'

export default {
  name: 'PresaleForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const presaleForm = useFormData(KEY, presaleFormData)

    return { presaleForm, data: computed(() => getFormData(presaleForm.value)) }
  }
}
</script>
