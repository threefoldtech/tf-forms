<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Investment Form</h1>

    <FormManager
      :hx="{
        post: $api + '/invests',
        ext: 'json-enc'
      }"
      :data="{
        email: authStore.user?.email,
        code: authStore.user?.code,
        phone,
        referal_code,
        invest_slots,
        invest_venture,
        invest_tf
      }"
      @before:submit="loading = true"
      @after:submit="loading = false"
    >
      <FormPages v-model="investmentForm" />

      <div class="mt-7">
        <FormPagination :length="investmentForm.length" :loading="loading" />
      </div>
    </FormManager>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, investmentFormData } from '../data'
import { computed, ref } from 'vue'
import { useAuthStore } from '@/stores/auth'

const KEY = 'INVESTMENT_FORM'

export default {
  name: 'InvestmentForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const investmentForm = useFormData(KEY, investmentFormData)
    const loading = ref(false)
    const authStore = useAuthStore()

    return {
      investmentForm,
      phone: computed(() => investmentForm.value[0][1].value),
      referal_code: computed(() => investmentForm.value[0][2].value),
      invest_slots: computed(() => investmentForm.value[1][1].value),
      invest_venture: computed(() => investmentForm.value[1][3].value),
      invest_tf: computed(() => investmentForm.value[1][5].value),
      loading,
      authStore
    }
  }
}
</script>
