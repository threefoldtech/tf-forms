<template>
  <div class="relative flex items-start">
    <div class="flex h-6 items-center">
      <input
        :id="'checkbox-' + uid"
        type="checkbox"
        class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600"
        :value="$props.modelValue"
        @input="$emit('update:model-value', $event)"
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
    modelValue: { type: String }
  },
  setup() {
    const { uid } = getCurrentInstance()!
    return { uid }
  }
}
</script>
