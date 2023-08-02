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
      <FormPages v-model="investmentForm" />

      <div class="mt-7">
        <div class="mb-3" v-if="success || error">
          <t-alert :type="success ? 'success' : 'error'">
            {{ error || 'Successfully saved your form.' }}
          </t-alert>
        </div>
        <FormPagination :length="investmentForm.length" :loading="loading" />
      </div>
    </FormManager>
    <p v-else class="font-bold animate-pulse text-center mt-32">Loading...</p>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, investmentFormData, setData, hasFormData } from '../data'
import { computed, inject, onMounted, ref } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { TAlert } from '@/components/tailwind'

const KEY = 'INVESTMENT_FORM'

export default {
  name: 'InvestmentForm',
  components: { FormManager, FormPages, FormPagination, TAlert },
  setup() {
    const loading = ref(false)
    const authStore = useAuthStore()

    const error = ref('')
    const success = ref(false)
    const init = ref(false)
    function afterRequest(res: { message?: string }) {
      loading.value = false
      if (res.message) {
        error.value = res.message
      } else {
        success.value = true
      }
    }

    const $globals = inject('$globals')! as { $api: string }
    const investmentForm = useFormData(KEY, investmentFormData)

    onMounted(async () => {
      if (!hasFormData(KEY)) {
        const res = await fetch(
          $globals.$api +
            '/invests?email=' +
            authStore.user!.email +
            '&code=' +
            authStore.user!.code
        )
        const data = await res.json()

        if (!data.message) {
          investmentForm.value = setData(investmentFormData, {
            0: {
              1: data.phone,
              2: data.referal_code
            },
            1: {
              1: data.invest_slots,
              3: data.invest_venture,
              5: data.invest_tf
            }
          })
        }
      }
      init.value = true
    })

    return {
      investmentForm,
      phone: computed(() => investmentForm.value[0][1].value),
      referal_code: computed(() => investmentForm.value[0][2].value),
      invest_slots: computed(() => investmentForm.value[1][1].value),
      invest_venture: computed(() => investmentForm.value[1][3].value),
      invest_tf: computed(() => investmentForm.value[1][5].value),
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
