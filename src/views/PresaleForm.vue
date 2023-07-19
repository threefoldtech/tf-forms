<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Pre-Sale Form</h1>

    <form>
      <FormRenderer v-model="presaleForm" />

      <div class="mt-7">
        <t-btn>Submit</t-btn>
      </div>
    </form>
  </section>
</template>

<script lang="ts">
import FormRenderer, { type FormInput } from '../components/FormRenderer.vue'

import { TBtn } from '../components/tailwind'
import { ref, watch } from 'vue'

const KEY = 'PRESALE_FORM'

export default {
  name: 'PresaleForm',
  components: { FormRenderer, TBtn },
  setup() {
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

    const maybePresaleForm = localStorage.getItem(KEY)
    if (maybePresaleForm === null) {
      localStorage.setItem(KEY, JSON.stringify(form))
    } else {
      form = JSON.parse(maybePresaleForm!)
    }

    const presaleForm = ref<FormInput[]>(form)
    watch(
      presaleForm,
      (form) => {
        localStorage.setItem(KEY, JSON.stringify(form))
        console.log(form)
      },
      { deep: true }
    )

    return { presaleForm }
  }
}
</script>

<!-- <template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Pre-Sale Form</h1>

    <form>
      <t-input label="Email" type="email" placeholder="Your email" required />

      <div class="my-5">
        <t-input label="Telephone Number" type="text" placeholder="Your answer" required />
      </div>

      <div class="mb-5">
        <t-input
          label="Referral code"
          placeholder="Your answer"
          required
          sub-label="Ask whoever introduced you to get such a code."
        />
      </div>

      <t-btn>Submit</t-btn>
    </form>
  </section>
</template>

<script lang="ts">
import { TInput, TBtn } from '../components/tailwind'

export default {
  name: 'PresaleForm',
  components: { TInput, TBtn }
}
</script> -->
