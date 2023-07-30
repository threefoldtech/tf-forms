<template>
  <input
    :id="'radio-' + uid"
    :name="name"
    type="radio"
    :value="value"
    :checked="value === current"
    @input="updateModelValue"
    class="h-4 w-4 border-gray-300 text-indigo-600 focus:ring-indigo-600"
    :readonly="readonly || false"
    :disabled="readonly"
  />
  <label
    :for="'radio-' + uid"
    class="ml-1 block text-sm font-medium leading-6 text-gray-900"
    v-html="label"
  />
</template>

<script lang="ts">
import { getCurrentInstance } from 'vue'

export default {
  name: 'TRadio',
  props: {
    label: { type: String, required: true },
    name: String,
    value: { type: String, required: true },
    current: String,
    readonly: Boolean
  },
  emits: { 'update:model-value': (value: string) => value },
  setup(_, { emit }) {
    const { uid } = getCurrentInstance()!

    function updateModelValue(e: Event) {
      const target = e.target as HTMLInputElement
      emit('update:model-value', target.value)
    }

    return { uid, updateModelValue }
  }
}
</script>
