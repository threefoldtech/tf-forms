<template>
  <div
    v-for="(_, index) in modelValue"
    v-show="manager ? index === manager.current.value : true"
    :key="index"
  >
    <FormRenderer v-model="$props.modelValue[index]" :readonly="readonly" />
  </div>
</template>

<script lang="ts">
import type { PropType } from 'vue'
import FormRenderer, { type FormInput } from './FormRenderer.vue'
import { useFormManager } from './FormManager.vue'

export default {
  name: 'FormPages',
  components: { FormRenderer },
  props: {
    modelValue: {
      type: Array as PropType<FormInput[][]>,
      required: true
    },
    readonly: Boolean
  },
  setup() {
    const manager = useFormManager()!
    return { manager }
  }
}
</script>
