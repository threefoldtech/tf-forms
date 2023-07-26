<template>
  <fieldset class="mt-4">
    <div
      :class="{
        'flex items-center bg-gray-100 p-3': inline,
        'space-y-4': !inline
      }"
    >
      <p class="mr-7 font-semibold leading-6 text-gray-900 w-32" v-if="label && inline">
        {{ label }}
      </p>
      <div
        v-for="(input, index) in inputs"
        :key="index"
        class="flex items-center"
        :class="{ 'mr-5': inline }"
      >
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
    modelValue: { type: String, required: true },
    inline: { type: Boolean, default: () => false },
    label: String
  },
  emits: { 'update:model-value': (value: string) => value }
}
</script>
