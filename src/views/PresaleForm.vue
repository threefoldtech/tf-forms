<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Pre-Sale Form</h1>
    <FormManager
      :hx="{
        post: $api + '/presale',
        ext: 'json-enc'
      }"
      :data="{
        email: 'elmdarym@incubaid.com',
        code: 'mohamed',
        phone,
        referal_code,
        phone_orders,
        node_orders,
        reason
      }"
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
import { useFormData, presaleFormData } from '@/data'
import { computed } from 'vue'

const KEY = 'PRESALE_FORM'

export default {
  name: 'PresaleForm',
  components: { FormManager, FormPages, FormPagination },
  setup() {
    const presaleForm = useFormData(KEY, presaleFormData)

    return {
      presaleForm,
      phone: computed(() => presaleForm.value[0][1].value),
      referal_code: computed(() => presaleForm.value[0][2].value),
      phone_orders: computed(() =>
        Array.from({ length: 4 }).map((_, i) => ({
          item: presaleForm.value[1][1 + i].name,
          quantity: presaleForm.value[1][1 + i].value
        }))
      ),
      node_orders: computed(() =>
        Array.from({ length: 2 }).map((_, i) => ({
          item: presaleForm.value[1][6 + i].name,
          quantity: presaleForm.value[1][6 + i].value
        }))
      ),
      reason: computed(() => presaleForm.value[1][9].value)
    }
  }
}
</script>
