<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Investment Form</h1>

    <form ref="formElement">
      <FormRenderer v-model="investmentForm" />

      <div class="mt-7">
        <t-btn>Submit</t-btn>
      </div>
    </form>
  </section>
</template>

<script lang="ts">
import FormRenderer, { type FormInput } from '../components/FormRenderer.vue'

import { TBtn } from '../components/tailwind'
import { onMounted, ref, watch } from 'vue'

const KEY = 'INVESTMENT_FORM'

export default {
  name: 'InvestmentForm',
  components: { FormRenderer, TBtn },
  setup() {
    const formElement = ref(null)
    onMounted(() => {
      ;(window as any).htmx.process(formElement.value)
    })

    let form: FormInput[] = [
      {
        label: 'Email',
        placeholder: 'Your email',
        type: 'email',
        value: ''
      },
      {
        label: 'Telephone Number',
        placeholder: 'Your answer',
        value: '',
        class: 'my-5'
      },
      {
        label: 'Referral code',
        subLabel: 'Ask whoever introduced you to get such a code.',
        value: ''
      }
    ]

    const maybeInvestmentForm = localStorage.getItem(KEY)
    if (maybeInvestmentForm === null) {
      localStorage.setItem(KEY, JSON.stringify(form))
    } else {
      form = JSON.parse(maybeInvestmentForm!)
    }

    const investmentForm = ref<FormInput[]>(form)
    watch(
      investmentForm,
      (form) => {
        localStorage.setItem(KEY, JSON.stringify(form))
        console.log(form)
      },
      { deep: true }
    )

    return { investmentForm, formElement }
  }
}
</script>
