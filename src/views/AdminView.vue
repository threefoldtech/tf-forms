<template>
  <h1 class="text-4xl capitalize font-bold mb-5">{{ formType }} List</h1>

  <p v-if="loading" class="font-bold animate-pulse text-center mt-32">Loading...</p>
  <div v-else>
    <div>
      <label class="block text-sm font-medium leading-6 text-gray-900"> Select an email </label>
      <select
        class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6"
        v-model="selectedIndex"
      >
        <option
          v-for="(form, index) in forms"
          :key="form.email"
          :value="index.toString()"
          :selected="index.toString() === selectedIndex"
        >
          {{ form.email }}
        </option>
      </select>
    </div>

    <form-pages :model-value="forms[selectedIndex!]" readonly />
  </div>
</template>

<script lang="ts">
import { setData, contactFormData, investmentFormData, presaleFormData } from '@/data'
import { useAuthStore } from '@/stores/auth'
import { inject, onMounted, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import FormPages from '@/components/FormPages.vue'

export default {
  name: 'AdminView',
  components: { FormPages },
  setup() {
    const $globals = inject('$globals') as { $api: string }
    const authStore = useAuthStore()
    const route = useRoute()
    const loading = ref(false)
    const selectedIndex = ref<`${number}` | null>(null)

    const formType = ref<string>()
    const forms = ref<any[]>([])

    watch(() => route.params.form, loadFormList)
    onMounted(loadFormList)

    function loadFormList() {
      loading.value = true
      selectedIndex.value = null
      formType.value = route.params.form as string

      window.htmx.ajax(
        'GET',
        $globals.$api +
          '/' +
          route.params.form +
          '/all?email=' +
          authStore.user!.email +
          '&code=' +
          authStore.user!.code,
        {
          handler: (_: HTMLElement, res: { xhr: XMLHttpRequest }) => {
            forms.value = _setFormData(JSON.parse(res.xhr.response))
            loading.value = false
            if (forms.value.length > 0) {
              selectedIndex.value = '0'
            }
          }
        }
      )
    }

    function _setFormData(data: any[]) {
      const type = route.params.form as 'contacts' | 'invests' | 'presales'

      switch (type) {
        case 'contacts': {
          return data.map((data) => {
            const x = setData(contactFormData, {
              0: {
                1: data.phone,
                2: data.about,
                4: data.interests['tf_cloud'],
                5: data.interests['venture_creator'],
                6: data.interests['licenses'],
                7: data.interests['dk']
              }
            })
            ;(x as any).email = data.email
            return x
          })
        }

        case 'invests': {
          return data.map((data) => {
            console.log(data)

            const x = setData([investmentFormData.flat(1)], {
              0: {
                1: data.phone,
                2: data.referal_code,

                4: data.invest_slots,
                6: data.invest_venture,
                8: data.invest_tf
              }
            })
            ;(x as any).email = data.email
            return x
          })
        }

        case 'presales': {
          return data.map((data) => {
            console.log(data)

            const x = setData([presaleFormData.flat(1)], {
              0: {
                1: data.phone,
                2: data.referal_code,

                4: data.phone_orders.find((p: any) => p.item === 'phone0').quantity,
                5: data.phone_orders.find((p: any) => p.item === 'phoneA').quantity,
                6: data.phone_orders.find((p: any) => p.item === 'phoneY').quantity,
                7: data.phone_orders.find((p: any) => p.item === 'phoneX').quantity,

                9: data.node_orders.find((n: any) => n.item === '3NodeSilver').quantity,
                10: data.node_orders.find((n: any) => n.item === '3NodeGold').quantity,

                12: data.reason
              }
            })
            ;(x as any).email = data.email
            return x
          })
        }
      }

      return []
    }

    return { authStore, route, forms, loading, formType, selectedIndex }
  }
}
</script>
