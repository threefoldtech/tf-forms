<template>
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
</script>
