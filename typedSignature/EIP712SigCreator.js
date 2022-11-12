import { utils , Wallet } from "ethers";
import { _TypedDataEncoder } from "@ethersproject/hash";

const wallet = new Wallet.createRandom();

const cekDataExample = [
    {
        name: "eImzaVerifier",
        version:"1",
        chainId:"TBD",
        verifyingContract:"TBD",
    },
    {
        Content: [
            {name: "deadline", type: "uint256"},
            {name: "data", type: "string"}
        ],
        Imzali: [
            {name: "tip", type: "uint256"},
            {name: "content", type: "Content"}
        ]
    },
    {
        tip: 1,
        content: {
            deadline: 23124124124,
            data:"https://www.edevlet.com/cek-no-13212412"}
        }
];

const receteDataExample = [
    {
        name: "eImzaVerifier",
        version:"1",
        chainId:"TBD",
        verifyingContract:"TBD",
    },
    {
        Content: [
            {name: "data", type: "string"}
        ],
        Imzali: [
            {name: "tip", type: "uint256"},
            {name: "content", type: "Content"}
        ]
    },
    {
        tip: 2,
        content: {
            data:"https://www.enabiz.com/recete-no-13212412"}
        }
];

const ogrenciBelgeDataExample = [
    {
        name: "eImzaVerifier",
        version:"1",
        chainId:"TBD",
        verifyingContract:"TBD",
    },
    {
        Content: [
            {name: "data", type: "string"}
        ],
        Imzali: [
            {name: "tip", type: "uint256"},
            {name: "content", type: "Content"}
        ]
    },
    {
        tip: 3,
        content: {
            data:"https://www.yok.com/ogrenci-belge-no-13212412"}
        }
];

const signed = await wallet._signTypedData(...cekDataExample);

