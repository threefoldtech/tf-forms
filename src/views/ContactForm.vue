<template>
  <section>
    <h1 class="text-5xl text-white font-bold mb-10">Contact Form</h1>

    <form>
      <tw-input label="Email" type="email" placeholder="Your email" required />
      <tw-input label="Telephone Number" placeholder="Your telephone number" required />
      <tw-input
        label="Some more information About You"
        type="textarea"
        placeholder="Your answer"
        required
      />

      <div>
        <span class="block mb-4">
          What are you interested in?<br />Please choose what is relevant for you, can select more
          than one.
        </span>
        <tw-input
          type="checkbox"
          label="ThreeFold Cloud = automous cloud as basis for a new Internet"
        />
        <tw-input
          type="checkbox"
          label="OurWorld Venture Creator = our mother company, giving birth to companies like ThreeFold"
        />
        <tw-input
          type="checkbox"
          label="Blocks of Licenses/Slots for Companies in a New Sovereign Digital FreeZone"
        />
        <tw-input type="checkbox" label="I don't know yet" />
      </div>

      <button
        class="mt-5 text-white focus:ring-4 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-blue-800"
        type="submit"
      >
        Submit
      </button>
    </form>
  </section>
</template>

<script lang="ts">
import { TwInput } from '../components/tailwind'

export default {
  name: 'ContactForm',
  components: { TwInput }
}
</script>
