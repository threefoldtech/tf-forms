<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Contact Form</h1>

    <form
      ref="formElement"
      hx-post="https://jsonplaceholder.typicode.com/users/1"
      hx-ext="json-enc"
      hx-confirm="Are you sure you wish to delete your account?"
    >
      <FormRenderer v-model="contactForm" />

      <t-btn type="submit">Submit</t-btn>
    </form>
  </section>
</template>

<script lang="ts">
import FormRenderer, { type FormInput } from '../components/FormRenderer.vue'

import { TBtn } from '../components/tailwind'
import { onMounted, ref, watch } from 'vue'

const KEY = 'CONTACT_FORM'

export default {
  name: 'ContactForm',
  components: { FormRenderer, TBtn },
  setup() {
    const formElement = ref(null)
    onMounted(() => (window as any).htmx.process(formElement.value))

    let form: FormInput[] = [
      {
        label: 'Email',
        placeholder: 'Your email',
        type: 'email',
        value: '',
        name: 'email'
      },
      {
        label: 'Telephone Number',
        placeholder: 'Your answer',
        value: '',
        class: 'my-5',
        name: 'phone'
      },
      {
        label: 'Some more information About You',
        placeholder: 'Your answer',
        type: 'textarea',
        value: '',
        class: 'mb-5',
        name: 'about'
      },
      {
        label: 'What are you interested in?',
        subLabel: 'Please choose what is relevant for you, can select more than one.',
        type: 'block'
      },
      {
        label: 'ThreeFold Cloud = automous cloud as basis for a new Internet',
        type: 'checkbox',
        value: false,
        name: 'tf-cloud'
      },
      {
        label:
          'OurWorld Venture Creator = our mother company, giving birth to companies like ThreeFold',
        type: 'checkbox',
        value: false,
        name: 'venture-creator'
      },
      {
        label: 'Blocks of Licenses/Slots for Companies in a New Sovereign Digital FreeZone',
        type: 'checkbox',
        value: false,
        name: 'licenses'
      },
      {
        label: "I don't know yet",
        type: 'checkbox',
        value: false,
        class: 'mb-7',
        name: 'dk'
      }
    ]

    const maybeContactForm = localStorage.getItem(KEY)
    if (maybeContactForm === null) {
      localStorage.setItem(KEY, JSON.stringify(form))
    } else {
      form = JSON.parse(maybeContactForm!)
    }

    const contactForm = ref<FormInput[]>(form)
    watch(
      contactForm,
      (form) => {
        localStorage.setItem(KEY, JSON.stringify(form))
        console.log(form)
      },
      { deep: true }
    )

    return { contactForm, formElement }
  }
}
</script>
