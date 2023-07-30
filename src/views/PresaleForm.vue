<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Pre-Sale Form</h1>
    <FormManager
      :hx="{
        post: $api + '/presale',
        ext: 'json-enc'
      }"
      :data="{
        email: authStore.user?.email,
        code: authStore.user?.code,
        phone,
        referal_code,
        phone_orders,
        node_orders,
        reason
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
      <FormPages v-model="presaleForm" />

      <div class="mt-7">
        <div class="mb-3" v-if="success || error">
          <t-alert :type="success ? 'success' : 'error'">
            {{ error || 'Successfully saved your form.' }}
          </t-alert>
        </div>
        <FormPagination :length="presaleForm.length" :loading="loading" />
      </div>
    </FormManager>
    <p v-else class="font-bold animate-pulse text-center mt-32">Loading...</p>
  </section>
</template>

<script lang="ts">
import FormPages from '../components/FormPages.vue'
import FormPagination from '../components/FormPagination.vue'
import FormManager from '../components/FormManager.vue'
import { useFormData, presaleFormData, hasFormData, setData } from '@/data'
import { computed, inject, onMounted, ref } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { TAlert } from '@/components/tailwind'

const KEY = 'PRESALE_FORM'

export default {
  name: 'PresaleForm',
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
    const presaleForm = useFormData(KEY, presaleFormData)

    onMounted(async () => {
      if (!hasFormData(KEY)) {
        const res = await fetch(
          $globals.$api +
            '/presales?email=' +
            authStore.user!.email +
            '&code=' +
            authStore.user!.code
        )
        const data = JSON.parse(await res.json())

        if (!data.message) {
          presaleForm.value = setData(presaleFormData, {
            0: {
              1: data.phone,
              2: data.referal_code
            },
            1: {
              1: data.phone_orders[0].quantity,
              2: data.phone_orders[1].quantity,
              3: data.phone_orders[2].quantity,
              4: data.phone_orders[3].quantity,

              6: data.node_orders[0].quantity,
              7: data.node_orders[0].quantity,

              9: data.reason
            }
          })
        }
      }
      init.value = true
    })

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
      reason: computed(() => presaleForm.value[1][9].value),
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
