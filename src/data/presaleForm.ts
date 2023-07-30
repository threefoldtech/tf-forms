import type { FormInput } from '@/components/FormRenderer.vue'

export const presaleFormData: FormInput[][] = [
  [
    {
      label: '',
      type: 'block'
    },
    {
      label: 'Telephone Number',
      placeholder: 'Your answer',
      value: '',
      class: 'my-5',
      name: 'phone'
    },
    {
      label: 'Referral code',
      subLabel: 'Ask whoever introduced you to get such a code.',
      value: '',
      placeholder: 'Your answer',
      name: 'referral_code'
    }
  ],
  [
    {
      type: 'block',
      label: 'I would Like To Pre-Order one of the First OurPhones !',
      subLabel: `
      OurPhone is selling an initial batch of OurPhones.
      <ul>
        <li>We will contact you with more information about cost and delivery times.</li>
        <li>We will only start if we get to at least 1m EUR worth of orders.</li>
        <li>Each phone includes the device, private membership, applications, storage, compute capacity, wallet, ...</li>
      </ul>

      The Phones
      <ul>
        <li>OurPhone 0 : +- 25 EUR/month</li>
        <li>OurPhone A,Y,X : +- 40, 50 or 60 EUR/month</li>
      </ul>

      Please be aware, we utilize an existing, efficient, and reliable mobile phone hardware platform. However, we substitute the operating system and install a new sovereign application software stack.
      `
    },
    {
      type: 'radio',
      label: 'OurPhone 0',
      name: 'phone0',
      value: '',
      radioInputs: [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: 'More', value: 'more' }
      ],
      inline: true
    },
    {
      type: 'radio',
      label: 'OurPhone A (6a)',
      name: 'phoneA',
      value: '',
      radioInputs: [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: 'More', value: 'more' }
      ],
      inline: true
    },
    {
      type: 'radio',
      label: 'OurPhone Y (7)',
      name: 'phoneY',
      value: '',
      radioInputs: [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: 'More', value: 'more' }
      ],
      inline: true
    },
    {
      type: 'radio',
      label: 'OurPhone X  (7pro)',
      name: 'phoneX',
      value: '',
      radioInputs: [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: 'More', value: 'more' }
      ],
      inline: true
    },
    {
      type: 'block',
      class: 'mt-10',
      label:
        'I Would Like to become a ThreeFold Internet Capacity Provider (also called ThreeFold Farmer)',
      subLabel: `
      Our 3Nodes are the backbone of our new internet, become a valued node in our network.
      <ul>
        <li>3Node Silver = 16GB, 1 TB disk = 800 EUR</li>
        <li>3Node Gold = 32GB, 2 TB disk = 1300 EUR</li>
      </ul>
      More info see <a href="https://www.threefold.io/farm" target="_blank">https://www.threefold.io/farm</a>
      <br />
      Become a cornerstone of the new Internet, providing secure storage and compute for your friends. All our Digital Twins and our OurPhones uses the capacity from this decentralized network of computers. A farmer receives rewards from the decentralized network in line to the uptime and size of your 3Node.
      <br />
      <strong>"BE THE INTERNET"</strong><br />
      I want to buy one or more 3Nodes:
      `
    },
    {
      type: 'radio',
      label: '3Node Silver',
      name: '3NodeSilver',
      value: '',
      radioInputs: [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: 'More', value: 'more' }
      ],
      inline: true
    },
    {
      type: 'radio',
      label: '3Node Gold',
      name: '3NodeGold',
      value: '',
      radioInputs: [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: 'More', value: 'more' }
      ],
      inline: true
    },
    {
      type: 'block',
      label:
        'I Would Like To Pre-Order My Private Personal Sovereign Company in a Sovereign FreeZone',
      subLabel: `
      Your Phone and your Digital Life can be connected to a personal company in a real sovereign free zone.<br/>
      Imagine the ultimate in sovereignty = a combination of legal, financial and digital privacy.<br /><br />
      Own your assets in a safe place, organize your professional life, pay less tax, collaborate with like minded people, no more need for complicated banking transactions.... All is automated through your phone and decentralized safe financial, administrative and collaboration stack.<br />
      Such a service normally costs about 20,000 USD per year, we are thinking 1,000 USD for 3 years.<br />
      No reason to do anything in the gray zone, take your destiny in your own hands, safe and crispy clean.<br />
      We will send you more information soon once we understand your interest.<br />
      `,
      class: 'mt-10'
    },
    {
      type: 'radio',
      name: 'orderFor',
      value: '',
      radioInputs: [
        { label: 'Just for Myself.', value: '1' },
        { label: 'For Myself and my Friends.', value: '2' },
        {
          label: 'I would like to become a partner and resell Sovereign Companies of the freeZone.',
          value: '3'
        }
      ]
    }
  ]
]
