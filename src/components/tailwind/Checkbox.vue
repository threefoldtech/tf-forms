<template>
  <div class="relative flex items-start">
    <div class="flex h-6 items-center">
      <input
        :id="'checkbox-' + uid"
        type="checkbox"
        class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600"
        :checked="$props.modelValue"
        @input="updateModelValue"
        :name="name"
        :value="$props.modelValue"
      />
    </div>
    <div class="ml-3 text-sm leading-6">
      <label :for="'checkbox-' + uid" class="text-gray-900">{{ label }}</label>
    </div>
  </div>
</template>

<script lang="ts">
import { getCurrentInstance } from 'vue'

export default {
  name: 'TCheckbox',
  props: {
    label: String,
    modelValue: { type: Boolean },
    name: String
  },
  emits: { 'update:model-value': (value: any) => value },
  setup(_, { emit }) {
    const { uid } = getCurrentInstance()!
    return {
      uid,
      updateModelValue(e: Event) {
        const target = e.target as HTMLInputElement
        emit('update:model-value', target.checked)
      }
    }
  }
}
</script>
