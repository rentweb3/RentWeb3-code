import { Center, Heading, VStack, Wrap, WrapItem } from "@chakra-ui/react";
import React from "react";
import UnqiuenessCard from "./UniquenessCard";

function Uniqueness() {
  return (
    <VStack
      bg={"black"}
      height={"fit-content"}
      minH={"100vh"}
      width={"100%"}
      paddingTop={"5vh"}
      paddingBottom={"5vh"}
      spacing={5}
      justify={"center"}
    >
      <Center width={"100%"}>
        <Heading color={"white"} fontSize={"3.5em"}>
          Our Uniqueness
        </Heading>
      </Center>

      <Wrap justify={"center"} spacing={5}>
        <WrapItem>
          <UnqiuenessCard
            title={"Ease of Use"}
            description={
              "Our platform is easy to understand and easy to use even for a non-technical person. We are aiming to provide great value with simple user interface and fast navigation inside the website."
            }
            btnLink={"https://github.com/rentweb3/Rentweb3-docs"}
            btnCaption={"Know More"}
          />
        </WrapItem>
        <WrapItem>
          <UnqiuenessCard
            title={"Dapps renting"}
            description={
              "Currently we are the only platform that provides the renting of Dapps as well as NFTs. We are on our way to implement the usecases of NFTs by connecting with various NFT based online games "
            }
            btnCaption={"Rent Dapp"}
            btnLink={"/RentDappInformation"}
          />
        </WrapItem>
        <WrapItem>
          <UnqiuenessCard
            title={"Standardized"}
            description={
              "Following the standards in the code - like using ERC-4907 for NFT Renting , give us an edge over competitors. Moreover , our smart contracts are well commented and easy to understand"
            }
            btnCaption={"View Code"}
            btnLink={
              "https://github.com/rentweb3/RentWeb3-code/tree/master/contracts"
            }
          />
        </WrapItem>
      </Wrap>
    </VStack>
  );
}

export default Uniqueness;
