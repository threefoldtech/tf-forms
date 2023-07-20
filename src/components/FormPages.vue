<template>
  <div v-for="(_, index) in modelValue" v-show="index === manager.current.value" :key="index">
    <FormRenderer v-model="$props.modelValue[index]" />
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
    }
  },
  setup() {
    const manager = useFormManager()!
    return { manager }
  }
}
</script>
