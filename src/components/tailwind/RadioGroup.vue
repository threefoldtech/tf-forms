<template>
  <fieldset class="mt-4">
    <div class="space-y-4">
      <div v-for="(input, index) in inputs" :key="index" class="flex items-center">
        <t-radio
          :label="input.label"
          :name="name"
          :value="input.value"
          @update:model-value="$emit('update:model-value', $event)"
        />
      </div>
    </div>
  </fieldset>
</template>

<script lang="ts">
import type { PropType } from 'vue'
import type { FormInput } from '../FormRenderer.vue'
import TRadio from './Radio.vue'

export default {
  name: 'TRadioGroup',
  components: { TRadio },
  props: {
    name: String,
    inputs: Array as PropType<FormInput['radioInputs']>,
    modelValue: { type: String, required: true }
  },
  emits: { 'update:model-value': (value: string) => value }
}
</script>
