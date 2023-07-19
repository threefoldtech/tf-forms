<template>
  <section>
    <h1 class="text-5xl font-bold mb-10">Contact Form</h1>

    <form>
      <t-input label="Email" type="email" placeholder="Your email" required />

      <div class="my-5">
        <t-input label="Telephone Number" type="text" placeholder="Your answer" required />
      </div>

      <t-textarea label="Some more information About You" placeholder="Your answer" />

      <div class="my-5">
        <span class="block mb-3">
          <span class="block text-sm font-medium leading-6 text-gray-900">
            What are you interested in?
          </span>
          <span class="text-xs">
            Please choose what is relevant for you, can select more than one.
          </span>
        </span>

        <t-checkbox label="ThreeFold Cloud = automous cloud as basis for a new Internet" />
        <t-checkbox
          label="OurWorld Venture Creator = our mother company, giving birth to companies like ThreeFold"
        />
        <t-checkbox
          label="Blocks of Licenses/Slots for Companies in a New Sovereign Digital FreeZone"
        />
        <t-checkbox label="I don't know yet" />
      </div>

      <t-btn>Submit</t-btn>
    </form>
  </section>
</template>

<script lang="ts">
import { TInput, TTextarea, TCheckbox, TBtn } from '../components/tailwind'

export default {
  name: 'ContactForm',
  components: { TInput, TTextarea, TCheckbox, TBtn }
}
</script>
