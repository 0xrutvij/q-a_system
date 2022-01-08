/***************************
File:        README.txt (3/3)
Author:      Rutvij Shah
Net ID:      rds190000
Class:       AI CS 4365.002
Project:     Knowledge Representation
Description: Instructions for running the project.
***************************/

First, load the knowledge base into a SWI Prolog REPL prompt. If you're using a
local distribution, use the following command.

    swipl -s knowledge_base.pl


For the Q/A portion, all questions marked [Pre-Transaction] in the
knowledge_base.txt file will be run first.

Once an answer for those is obtained and recorded, we move on to the transaction.
As mentioned in the knowledge_base.txt file, following is the transaction
corresponding to the the statement in the project prompt.

Input: sub_transaction(john, utdBakery, bagels, "dozen", 12),
        sub_transaction(john, utdBakery, bagels, "dozen", 12),
        sub_transaction(john, utdBakery, bread, "loaf", 2).

Output: true.

The third part is running all the remaining questions, some of them are marked
[Post-Transaction] since they're dependent on the transaction having taken
place while the rest are agnostic and can be run at any time.

The answers vary depending upon the questions, but the expected answer is
trivially deduced based on the output for all questions in the project prompt.

There are 7 additional questions and answers provided to demonstrate the
abilities of the Q/A System.

For any questions or doubts, email rutvij.shah@utdallas.edu.
