<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Investment Form</h1>

    <FormManager>
      <FormPages v-model="investmentForm" />

      <div class="mt-7">
        <FormPagination :length="investmentForm.length" />
      </div>
    </FormManager>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, investmentFormData } from '../data'

const KEY = 'INVESTMENT_FORM'

export default {
  name: 'InvestmentForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const investmentForm = useFormData(KEY, investmentFormData)

    return { investmentForm }
  }
}
</script>
