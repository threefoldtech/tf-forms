<template>
  <div class="flex justify-between">
    <t-btn
      :disabled="disableBack"
      type="button"
      v-if="manager.current.value > 0"
      color="error"
      @click="manager.current.value--"
    >
      Back
    </t-btn>
    <div v-else />

    <t-btn
      :disabled="disableNext"
      type="button"
      v-if="manager.current.value < length - 1"
      color="success"
      @click="manager.current.value++"
    >
      Next
    </t-btn>
    <t-btn
      type="submit"
      :disabled="disableSubmit"
      v-else
      @click="$emit('click:submit', $event)"
      :loading="loading"
    >
      Submit
    </t-btn>
  </div>
</template>

<script lang="ts">
import { TBtn } from './tailwind'
import { useFormManager } from './FormManager.vue'

export default {
  name: 'FormPagination',
  components: { TBtn },
  props: {
    length: { type: Number, required: true },
    disableBack: Boolean,
    disableSubmit: Boolean,
    disableNext: Boolean,
    loading: Boolean
  },
  emits: {
    'click:submit': (e: MouseEvent) => e
  },
  setup() {
    const manager = useFormManager()!

    return { manager }
  }
}
</script>
