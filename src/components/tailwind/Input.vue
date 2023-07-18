<template>
  <div v-if="type === 'checkbox'" class="flex items-start mb-5 cursor-pointer">
    <div class="flex items-center h-5 cursor-pointer">
      <input
        :id="'input-checkbox-' + uid"
        type="checkbox"
        class="w-4 h-4 border rounded focus:ring-3 bg-gray-700 border-gray-600 focus:ring-blue-600 ring-offset-gray-800 cursor-pointer"
        :required="required"
      />
    </div>
    <label
      :for="'input-checkbox-' + uid"
      class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300"
    >
      {{ label }}
    </label>
  </div>

  <label v-else class="block mb-5 text-sm font-medium text-gray-900 dark:text-white">
    <span class="block mb-2">{{ label }} <span v-if="required" class="text-red-500">*</span> </span>

    <textarea
      v-if="type === 'textarea'"
      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      :placeholder="placeholder"
      :required="required"
      :rows="rows || 4"
      :style="{ resize: resizable ? undefined : 'none' }"
    ></textarea>
    <input
      v-else
      :type="type || 'text'"
      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
      :placeholder="placeholder"
      :required="required"
    />
  </label>
</template>

<script lang="ts">
import { getCurrentInstance } from 'vue'

export default {
  name: 'TwInput',
  props: {
    label: String,
    placeholder: String,
    required: Boolean,
    type: String,
    rows: Number,
    resizable: Boolean
  },
  setup() {
    const { uid } = getCurrentInstance()!

    return { uid }
  }
}
</script>
